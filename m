Date: Wed, 13 Feb 2002 09:00:02 +0100
From: Olaf Hering <olh@suse.de>
To: yellowdog-devel@lists.yellowdoglinux.com
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: new G4 dual 1 gig is here - how to install?
Message-ID: <20020213090002.B4386@suse.de>
References: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca> <D232876A-2024-11D6-A30D-0003938E434C@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D232876A-2024-11D6-A30D-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 12, Kevin B. Hendricks wrote:

> BTW: Are there any nice utilities to let me snoop through the OF device
> tree under Mac OSX.  I know I can get DisplayName Registry to work under
> MacOS 9.2 but would rather do my machine snooping under OSX if possible.

Copy the boot file in the root of a hfs partition, select that one as
boot volume. Boot to OF prompt, type "printenv boot-device", that will
give you a clue about that path name. Then change the ,\\:tbxi part to
,filename.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
