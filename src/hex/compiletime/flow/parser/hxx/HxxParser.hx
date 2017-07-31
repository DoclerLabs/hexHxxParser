package hex.compiletime.flow.parser.hxx;

#if macro
import haxe.macro.*;
import haxe.macro.Expr;
import hex.vo.ConstructorVO;
#end

/**
 * Lazy by default
 * @author Francis Bourre
 */
class HxxParser 
{
	/** @private */ function new() throw new hex.error.PrivateConstructorException();
	
	macro public static function activate() : haxe.macro.Expr.ExprOf<Bool>
	{
		//Sets the parser
		FlowExpressionParser.parser.buildMethodParser.set( 'hxx', HxxParser.parse );
		
		//Sets the builder
		hex.compiler.core.CompileTimeSettings.factoryMap.set( 'coconut.ui.macros.HXX', build );
		
		return macro true;
	}
	
	macro public static function desactivate() : haxe.macro.Expr.ExprOf<Bool>
	{
		FlowExpressionParser.parser.buildMethodParser.remove( 'hxx' );
		hex.compiler.core.CompileTimeSettings.factoryMap.remove( 'coconut.ui.macros.HXX' );
		return macro true;
	}
	
	#if macro
	public static function parse( 	parser : hex.compiletime.flow.parser.ExpressionParser, 
									constructorVO : ConstructorVO, 
									params : Array<Expr>, 
									expr : Expr ) : ConstructorVO
	{
		var dom 					= params.shift();
		constructorVO.type 			= 'coconut.ui.macros.HXX';
		constructorVO.arguments 	=[ macro coconut.ui.macros.HXX.hxx( $dom ) ];
		constructorVO.filePosition 	= expr.pos;
		constructorVO.lazy 			= true;
		return constructorVO;
	}
	
	static public function build<T:hex.compiletime.basic.vo.FactoryVOTypeDef>( factoryVO : T ) : Expr
	{
		var constructorVO 		= factoryVO.constructorVO;
		var e 					= constructorVO.arguments.shift();
		var idVar 				= constructorVO.ID;
		constructorVO.cType 	= tink.macro.Positions.makeBlankType( constructorVO.filePosition );

		//Building result
		return macro @:pos( constructorVO.filePosition ) $e;	
	}
	#end
}
