To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'Jerry Van Baren'" <vanbaren_gerald@si.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'laitingwai@yahoo.com'" <laitingwai@yahoo.com>
Subject: Re: Can I run linux without a file system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Jun 2002 14:17:29 PDT."
             <C08678384BE7D311B4D70004ACA371050B76351E@amer22.avnet.com>
Date: Fri, 21 Jun 2002 23:28:49 +0200
Message-Id: <20020621212854.C6F551030A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Karl,

in message <C08678384BE7D311B4D70004ACA371050B76351E@amer22.avnet.com> you wrote:
>
> My filesystem is 5.7 MB uncompressed.  And, for me
> (sorry Wolfgang!) I think that *is* minimal.  Well,
> not "minimal" in the sense of "as small as humanly
> possible", but at least "miniature" -- compared to
> more than 1000 MB for my desktop Linux host.  Our board
> isn't big: it has 16 MB of flash & 64 MB of RAM,
> can serve up telnet sessions & web pages, etc., and

Well, that's about what SELF contains -  which  takes  about  2.2  MB
uncompressed, 830 kB compressed.

> *	One doesn't just make a zip or .tgz file; rather,
> 	one must must make a filesystem structure per se,
> 	that Linux on the PPC board can mount.

There are patches out there that can load a .tgz file into a  ramdisk
upon boot, so instead a ramdisk image you can load a tarball.

> *	I could bulk-copy (cp -R) from $xroot to the
> 	filesystem image, *but* you can't cp around the
> 	files in /dev.  The script below is hackish

You can. RTFM. Pay attention to options like '-a' or '-R'.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If you can, help others. If you can't, at least don't hurt  others."
- the Dalai Lama

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
