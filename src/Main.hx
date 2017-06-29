package;

import hex.compiler.parser.flow.StaticFlowCompiler;
import hex.compiletime.flow.parser.hxx.HxxParser;
import hex.runtime.ApplicationAssembler;
import vdom.VDom.*;

/**
 * ...
 * @author Francis Bourre
 */
class Main
{
    static public function main() : Void
    {
		HxxParser.activate();
		var code = StaticFlowCompiler.compile( new ApplicationAssembler(), 'hxxTest.flow' );
		code.execute();
	}
}