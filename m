Date: Mon, 12 Jan 2004 02:16:42 +0100
From: Wouter Cloetens <wouter@mind.be>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: downloading source with specific changeset
Message-ID: <20040112011642.GI9059@roadkill.intern.mind.be>
References: <D73A25AA6E54D511AD74009027B1110F5BAFEB@ORION>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F5BAFEB@ORION>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jan 09, 2004 at 03:30:28PM -0500, Steven Blakeslee wrote:
> I am trying to download a specific revision of the linuxppc_2_4_devel tree,
> tag v2.4.21_linuxppc_2_4_devel, at
> http://ppc.bkbits.net:8080/linuxppc_2_4_devel
>
> The command I give is
> bk clone -r1.1308.1.36 http://ppc.bkbits.net/linuxppc_2_4_devel
>
> I thought the -r1.1308.1.36 would tell it to download up to changset
> 1.1308.1.36 but I keep getting the most recent version.  Can you please tell
> me what I am doing wrong.

bk clone / pull just manages a copy of the repository. You need to
export a specific version of the tree. After the bk clone command, try
this:
bk export -rv2.4.21_linuxppc_2_4_devel targetdir

--
There are 10 types of people in the world: Those who understand binary, and those who don't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
