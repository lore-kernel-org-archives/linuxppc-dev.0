Date: Wed, 10 Apr 2002 13:59:33 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <10583.020410@vanet.com.br>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Dan Malek'" <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: 8260 - Spurious interrupt when calling __sti()
In-reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F92@mail.mediatrix.com>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F92@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis,


Wednesday, April 10, 2002, 1:31:05 PM, you wrote:


<snip>

JDB> What is even more strange, I can put the 'sync' everywhere in the '__sti'
JDB> function, that is before the 'mfmsr', before the 'ori', or before the
JDB> 'mtmsr',
JDB> and the problem of spurious interrupt simply disappear. Remove it, it
JDB> reappears.

<snip>

JDB> Hard to explain...

Even harder to explain is why you're having to put those syncs in
__sti, since both my copies of 2.4.16 and 2.4.18-pre9 kernel sources
already have them in the code... and with the comment
"/* Some chip revs have problems here... */" !!!

[]'s, Scop                            mailto:scop@vanet.com.br

------------------------------------------------------------------
"We all lie in the gutter, but some of us look up at the stars."
-- Oscar Wilde


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
