Message-Id: <200003271913.OAA28080@mal-ach.watson.ibm.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Ani Joshi <ajoshi@shell.unixbox.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet 
In-Reply-To: Message from "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
   of "Mon, 27 Mar 2000 14:06:35 EST." <v03110706b505609771ce@[129.100.29.243]>
Date: Mon, 27 Mar 2000 14:13:48 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Gabriel's patch is the correct way to address the problem and
should be the one which goes into the public sources.

	I do not understand, however, why the patch only includes the "=m"
constraint on regw() and not regw16().  All of the inlined functions
should have constraints which reference the actual memory address read or
written to ensure proper dependencies in optimized code.

	The problem was the unnecessary "volatile" not the memory
constraint.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
