Date: Thu, 10 Dec 1998 10:23:46 -0600 (CST)
From: Vinai Roopchansingh <vroopcha@post.its.mcw.edu>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc, libc?
In-Reply-To: <Pine.LNX.3.96L.981130114432.9820C-100000@foblub.weh.andrew.cmu.edu>
Message-ID: <Pine.SOL.3.96.981210101524.10546A-100000@post.its.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am by no means any kind of expert in Linux system structure, but I'll
take a stab at it, as someday, I hope to be :)

libc and glibc are the system libraries.  You know when you compile a C
program, the "standard" functions you use (like printf, scanf, etc) have
to be defined and referenced somewhere, so the program knows what to do
with them ;) But remember, the linux OS (and UNIX in general) is C-based
so the operating system itself uses these same libraries, to define how
_IT_ (i.e. the OS) behaves. This also helps with consistency between our
OS and the software running on it.  This also is very important with
dynamic linking and shared objects, where the function is not "compiled"
into the program, but is called when needed by another program called a
linker ("ld" on linux, IIRC)

libc was the traditional (spell "x86") system libraries.  But since this
OS has traversed other architectures like no other has, there _IS_ a big
effort to try to standardize the libraries between all platforms running
linux ...

My $0.02.  Please correct me if I am wrong and/or missed out anything
critical, someone else .... :)

Cheers
Vinai




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
