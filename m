Mime-Version: 1.0
Message-Id: <v04220800b4572678a8f9@[129.105.9.226]>
In-Reply-To: <383130B3.FB987AD8@wanadoo.fr>
References: <v04220800b4568b66a977@[129.105.9.226]>
 <383130B3.FB987AD8@wanadoo.fr>
Date: Tue, 16 Nov 1999 09:30:19 -0600
To: Martin Costabel <costabel@wanadoo.fr>
From: Geoff Hutchison <ghutchis@wso.williams.edu>
Subject: Re: Building Question
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:23 AM +0100 11/16/99, Martin Costabel wrote:
>Fix the "undefined reference" error.
>You mean "undefined reference" isn't an error on x86?

That's my point--people compiling the *same* code don't get that error.

At 9:27 AM +0100 11/16/99, Wolfgang Denk wrote:
>I'm not really sure, but can you please check how  big  your  code  /
>data  segments  are? The PPC addressing model is limited in range for
>relative addressing - "REL24" indicates that you are overrunning  the
>relacatable range using 24 bit offsets...

I was afraid of that. Thanks. I'll see if I can tweak the linking 
order and see if that helps a bit. I'll also try gcc -Os and see if 
that helps.

-Geoff Hutchison
Williams Students Online
http://wso.williams.edu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
