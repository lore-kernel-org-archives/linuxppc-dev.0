Message-ID: <39B2D53F.9FBABB70@m2tech.co.nz>
Date: Mon, 04 Sep 2000 10:48:31 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: Stephen B Johnson <stevebj@inxpress.net>
CC: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel panic on mcp750
References: <39B28BB4.A52E1E69@inxpress.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen B Johnson wrote:

> I'm observing a kernel panic when booting the kernel on a Motorola
> MCP750.  The panic indicates "Kernel panic: No init found.  Try passing
> init= option to kernel."
>
> However, I pass init=3 as a parameter.
>
> Any suggestions?

by passing 'init=3' to the kernel, you are telling it to try and load a program called '3'.. is this what you want?? or do you want to
load a shell interpreter such as bash??

init=3 does not change the runlevel..

cheers,

ben

--
/\\------------------------------------------------------------------
ben.bodley/.m2technologyltd.nz/.benb@m2tech.co.nz/.64.9.4448307ext130


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
