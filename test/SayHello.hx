package;

/**
 * ...
 * @author Francis Bourre
 */
class SayHello extends coconut.ui.View<{ to: String }> 
{
	function render() '<p>Hello {to} !</p>';
}
