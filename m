Date: Wed, 5 Apr 2000 02:27:40 +0200
From: Olaf Hering <olh@suse.de>
To: "William H. Schultz" <whschult@uncc.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel args with miboot
Message-ID: <20000405022740.B20631@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <200004040459.XAA03713@lists.linuxppc.org> <38EA7D15.C453ED94@uncc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38EA7D15.C453ED94@uncc.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 04, William H. Schultz wrote:

> Maybe I'm just not as quick as everyone else, but how do you
> pass kernel arguments when using miboot?  I found some stuff
> when I looked at the "Sytem" file with ResEdit, but it
> didn't look like that's where I was supposed to put the
> stuff.  I also haven't found any documentation on the
> bootloader.

There is a resource CMDL, you can have two configurations. Just enter
your stuff carefully.
Documentation is available in .c fomat ;)


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
