In-Reply-To: <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be>
References: <20040614162359.GA7798@smtp.west.cox.net> <20040614173841.GA3247@suse.de> <20040614180734.GB3247@suse.de> <20040614205537.GB7798@smtp.west.cox.net> <20040614211931.GA21113@suse.de> <20040615161258.GA14528@smtp.west.cox.net> <20040615172511.GA21667@suse.de> <20040615174648.GC14528@smtp.west.cox.net> <20040703222918.GA10425@suse.de> <40E75DC7.7070601@coditel.net> <20040704024149.GB2146@smtp.west.cox.net> <Pine.GSO.4.58.0407041028480.21842@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E2EB9906-CDD7-11D8-92C8-000A95A0560C@us.ibm.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Olaf Hering <olh@suse.de>,
	Alan Modra <amodra@bigpond.net.au>,
	Stef Simoens <stefaan.simoens@coditel.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Andrew Morton <akpm@osdl.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] fix missing option in binutils version check
Date: Sun, 4 Jul 2004 11:33:31 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jul 4, 2004, at 3:32 AM, Geert Uytterhoeven wrote:
>
> Perhaps it makes sense to add a directive to the assembler to switch
> on the
> fly, cfr. the `.chip' directive on m68k? E.g. using
>
>     .chip 68040
>
> we switch to 68040 mode, and using
>
>     .chip 68k
>
> we switch back to generic mode. That way we can have instructions for
> different
> CPU types in the same kernel, while the assembler still checks the
> validity
> depending on the selected CPU type.

That's come up before, and iirc Alan Modra said the support isn't there
now for PPC and is relatively low on the priority list (but is on it).

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
