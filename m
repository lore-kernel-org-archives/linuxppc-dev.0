Date: Wed, 27 Oct 1999 20:19:28 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Netscape and missing libnullplugin.so
In-Reply-To: <199910271530.KAA32070@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.20.9910272004410.1425-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




  I don't think that netscape supports plugins, i to use the flash plugin (the
free one not macromedia's) some time ago but netscape never recognized the
plugin :(

  Kostas Gewrgiou.

On Wed, 27 Oct 1999, Kevin_Hendricks wrote:

> 
> Hi,
> 
> I now have the source to the java plugin for Netscape/Mozilla (via my license 
> with Blackdown) and I have ported both the java plugin 1.1.2 (allowing the use 
> of jdk118 inside Netscape and plugin 1.2 (to allow the forthcoming jdk 1.2.2 to 
> work within netscape).
> 
> I have been unable to get either plugin to be recognized by the latest Netscape 
> rpm available from LinuxPPC.
> 
> I went and downloaded the Sparc version of the plugin to see how the whole 
> process worked under Solaris and noticed that the Solaris Netscape plugins 
> already includes a libnullplugin.so which does not seem to exist in the ppc 
> version of Netscape.  The description of libnullplugin.so is that it helps 
> support plugins under Netscape.
> 
> Should there be a libnullplugin.so in /usr/lib/netscape/plugins/ under ppc?  Is 
> it needed to get other plugins to work?
> 
> Any info here would be greatly appreciated.
> 
> Thanks,
> 
> Kevin
> 
> 
> 
> --
> Kevin B. Hendricks
> Associate Professor of Operations and Information Technology
> Richard Ivey School of Business, University of Western Ontario
> London, Ontario  N6A-3K7  CANADA   
> khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959
> 
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
