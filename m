Mime-Version: 1.0
Message-Id: <v04220801b5da6e40f116@[10.0.0.42]>
In-Reply-To: <39AF9699.5529818B@student.ethz.ch>
References: 
 <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>	
 <39AE8559.A4F12B6D@relog.ch> <v04220804b5d51c963eff@[10.0.0.42]>
 <39AF9699.5529818B@student.ethz.ch>
Date: Tue, 5 Sep 2000 02:48:08 -0700
To: Michel Dänzer  <daenzerm@student.ethz.ch>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: asm statement in include/asm not ansi conform
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:44 PM +0200 9/1/00, Michel Dänzer wrote:

>Just putting Ani's r128 (or the whole xfree86) directory into the DRI tree
>should work, as the changes in the DRI branch are mostly outside the 2D
>driver. Please let me know if there are problems.

I did something similar -- merged the two versions of the 2D driver.
It worked.

I do find that I have to keep it at 16-bit at resolutions higher than
1024x768, otherwise there isn't enough memory for textures.


   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
