Date: Wed, 27 Oct 1999 09:06:27 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Netscape and missing libnullplugin.so
In-Reply-To: <199910271530.KAA32070@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.9910270903190.9455-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 27 Oct 1999, Kevin_Hendricks wrote:

> Should there be a libnullplugin.so in /usr/lib/netscape/plugins/ under ppc?  Is 
> it needed to get other plugins to work?

	you should get rid of libnullplugin.so, iirc its supposed to
prompt you and take you to a page where you can d/l plugin, but it has
been my experience with 3.x and 4.x that this plugin does not work.
also, is your NPX_PLUGIN_PATH set properly?


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
