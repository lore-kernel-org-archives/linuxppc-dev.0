Date: Thu, 27 Sep 2001 00:36:43 -0700
Subject: Re: debugging modules
From: Scott Anderson <scott_anderson@mvista.com>
To: ibm405gp <ibm405.linux@laposte.net>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <B7D8251A.270D%scott_anderson@mvista.com>
In-Reply-To: <3BB2CF9F.169AED1A@laposte.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


on 9/27/01 12:05 AM, ibm405gp at ibm405.linux@laposte.net wrote:
> I saw in a previous message that I would be able to debug modules
> instead of generating the kernel each time.
> Can somebody give me the procedure to follow?

I'll give you a quick pointer, but maybe someone else will give you
a better more detailed procedure.  The key is the add-symbol-file
command in gdb.  It takes an object file and an address.  Using
insmod -m (I believe - I'm aware from the office right now), you
can get the address of where a module gets loaded.  Then you use
add-symbol-file to teach gdb about this module and where it's at.

   Scott


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
