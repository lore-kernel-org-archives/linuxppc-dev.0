Message-ID: <3A68568E.F4A3A60@videotron.ca>
Date: Fri, 19 Jan 2001 10:00:29 -0500
From: Alain Birtz <abz@videotron.ca>
Reply-To: abz@videotron.ca
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: javac and "package not found error"
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The swing application work great with MacOS and CodeWarrior.
But when I try to compile the same application with javac under Linux
(Suse7.0)
I got "package not found error".

The first error message was for the "import javax.swing.*".
Setting -classpath to /usr/lib/netbeans21/lib21/swingall.tar solve this
line error.
But now javac complaint about every other import line.

The Sun site say that Java class are all in rt.jar. But I cannot found
any such
file in my HD. It seem that jdk was installed: /usr/lib hold a directory
called jdk1.1.8

Is there something like a default classpath ?

What can I do to solve this problem ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
