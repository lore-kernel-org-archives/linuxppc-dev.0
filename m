Date: Fri, 12 Feb 1999 16:37:31 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: CONFIG_PMAC_PBOOK vs. CONFIG_FB_COMPAT_XPMAC
Message-ID: <Pine.LNX.3.96LJ1.1b7.990212163524.5724A-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi--

this code in drivers/video/chipsfb.c will not compile if CONFIG_PMAC_PBOOK
is defined but CONFIG_FB_COMPAT_XPMAC is not:

#if (defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_FB_COMPAT_XPMAC))
        display_info.depth = bpp;
        display_info.pitch = fix->line_length;
#endif

i assume we are going to see fewer users compile in CONFIG_FB_COMPAT_XPMAC
since it's been depricated.

brad


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
