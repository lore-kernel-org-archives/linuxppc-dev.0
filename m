Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id D1607DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 May 2008 14:59:40 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so516278anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 May 2008 21:59:39 -0700 (PDT)
Message-ID: <fa686aa40805182159s7c73a42es9121efd003b2e246@mail.gmail.com>
Date: Sun, 18 May 2008 22:59:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Yoshio Kashiwagi" <kashiwagi@co-nss.co.jp>
Subject: Re: Xilinx PowerPC
In-Reply-To: <JN200805191318356.11133187@co-nss.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <480BA36D.1080000@dlasys.net>
	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>
	<480BA821.2030109@dlasys.net>
	<fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
	<480BD66B.90001@dlasys.net> <JM200804230904046.2598203@co-nss.co.jp>
	<482EFB8F.9090402@dlasys.net> <JV200805181113103.2504562@co-nss.co.jp>
	<4830F388.3060709@dlasys.net>
	<JN200805191318356.11133187@co-nss.co.jp>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, May 18, 2008 at 10:18 PM, Yoshio Kashiwagi
<kashiwagi@co-nss.co.jp> wrote:
> David-san,
>
> I posted this source code so that usage of SDMA could be shared.
> Probably this code will be able to be used also by Virtex-5 FXT.
> Since this source code is a reference level and start point as you
> say, it is happy that it is maintainable with people of this ML.
> I'll leave it in your hands about author.

It is probably appropriate for David to maintain your copyright notice
at the top of the file.  Also, you should provide your "signed-off-by"
line to confirm that there are no legal issues with you contributing
your code (see Documentation/SubmittingPatches for details).  Email it
to Dave, and he should preserve your signed-off-by line when he posts
his modified patch.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
