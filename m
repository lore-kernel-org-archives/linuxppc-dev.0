To: Paul Mackerras <paulus@samba.org>
Cc: "Dale Farnsworth" <dale@farnsworth.org>,
	Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Mar 2003 11:47:45 +1100."
             <15973.18737.651334.824024@argo.ozlabs.ibm.com>
Date: Wed, 05 Mar 2003 02:03:13 +0100
Message-Id: <20030305010318.6A4D3C6E0C@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <15973.18737.651334.824024@argo.ozlabs.ibm.com> you wrote:
>
> Why are we still using locations 0 and 4 if that is causing trouble?
> Why not change to 0xf0 and 0xf4 or something else out of the way?  We

BTW: _all_ this writing to kernel text is a Bad  Thing  (TM),  as  it
makes XIP (for example running from ROM) really difficult.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Of all the things I've lost, I miss my mind the most.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
