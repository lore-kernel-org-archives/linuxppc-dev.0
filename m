Message-Id: <v03110708b505647a5b6d@[129.100.29.243]>
In-Reply-To: <200003271913.OAA28080@mal-ach.watson.ibm.com>
References: Message from "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>   
 of "Mon, 27 Mar 2000 14:06:35 EST."
 <v03110706b505609771ce@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 27 Mar 2000 14:20:10 -0500
To: David Edelsohn <dje@watson.ibm.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Some issues to resolve with XFree 4.0 yet
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Okay I will add this.  But right now the regr16 and regw16 macros are not
used at all in the r128 code in xfree86 4.0. (I put them there only for
completeness and to match the x86 versions).


Thanks,

Kevin


At 14:13 -0500 3/27/00, David Edelsohn wrote:
>	Gabriel's patch is the correct way to address the problem and
>should be the one which goes into the public sources.
>
>	I do not understand, however, why the patch only includes the "=m"
>constraint on regw() and not regw16().  All of the inlined functions
>should have constraints which reference the actual memory address read or
>written to ensure proper dependencies in optimized code.
>
>	The problem was the unnecessary "volatile" not the memory
>constraint.
>
>David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
