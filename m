Message-Id: <200101191522.f0JFMvH26551@ashley.ivey.uwo.ca>
Date: Fri, 19 Jan 2001 10:22:56 -0500
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: javac and "package not found error"
Cc: linuxppc-dev@lists.linuxppc.org
To: abz@videotron.ca
Mime-Version: 1.0 (Apple Message framework v337)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Swing is now integrated with the Java 2 (JDK 1.2.2 / JDK 1.3) package.  When using jdk 1.1.8 swing must be added as an external package.

The problem was, late in the development of swing they changed the package names to help with its integration into the Java 2 platform.  Sun then released a new and improved standalone Swing package that matched these new package names.

So it sounds like you are out of sync.  Since you are using jdk 1.1.8, you need to get an external Swing package that is up to date from Sun (is the NetBeans one up to date).  That unfortunately may NOT be what is used under MacOS since the MacOS java system is quite old and dated (this is not true of MacOSX which ships with Java2 with integrated Swing).

Please check out the Sun site and grab the latest Swing (probably already integrated with NetBeans if it is a recent version).  If you still have problems, the code itself probably uses the old Swing package names and needs to be updated.  (I believe someone has a java application to make the necessary changes wholesale).

It may also be that the virtual machine is simply finding an older Swing package someplace in its classpath and that changing the classpath may be enough.  To change the classpath, you can use the environment variable CLASSPATH to set its intial value for the jdk 1.1.8 or pass info via the java command line.

Check out the Sun java pages that describe the Java Foundation Classes in more detail if you need more info.

Kevin

On Friday, January 19, 2001, at 10:00 AM, Alain Birtz wrote:

>
> The swing application work great with MacOS and CodeWarrior.
> But when I try to compile the same application with javac under Linux
> (Suse7.0)
> I got "package not found error".
>
> The first error message was for the "import javax.swing.*".
> Setting -classpath to /usr/lib/netbeans21/lib21/swingall.tar solve this
> line error.
> But now javac complaint about every other import line.
>
> The Sun site say that Java class are all in rt.jar. But I cannot found
> any such
> file in my HD. It seem that jdk was installed: /usr/lib hold a directory
> called jdk1.1.8
>
> Is there something like a default classpath ?
>
> What can I do to solve this problem ?
>
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
