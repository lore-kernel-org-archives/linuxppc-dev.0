Mime-Version: 1.0
Message-Id: <v04220800b5694dab4406@[129.105.186.171]>
In-Reply-To: <39437131.F1DD3AE6@wanadoo.fr>
References: <v04220801b568cc2210b4@[129.105.9.193]>
 <39437131.F1DD3AE6@wanadoo.fr>
Date: Sun, 11 Jun 2000 09:08:14 -0500
To: Martin Costabel <costabel@wanadoo.fr>
From: Geoff Hutchison <ghutchis@wso.williams.edu>
Subject: Re: Possible gcc bug?
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:00 PM +0200 6/11/00, Martin Costabel wrote:
>I think you do: You are passing over the array bounds. If I remember my
>C basics (which I never really learned either) correctly,
>
>double field[loopX][loopY];

Doh! Yes, as I said, I'll eat my words. This should fix things.

Thanks,

--
-Geoff Hutchison
Williams Students Online
http://wso.williams.edu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
