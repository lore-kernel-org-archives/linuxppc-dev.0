Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id 2BF1ADDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 15:27:06 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so2272935hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Apr 2008 21:27:04 -0700 (PDT)
Message-ID: <fa686aa40804012127n6db5c8a0sbe625b964c75b2d2@mail.gmail.com>
Date: Tue, 1 Apr 2008 22:27:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <18418.49494.457893.866627@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18412.58902.189124.391104@cargo.ozlabs.ibm.com>
	<47ED6BE5.9060807@semihalf.com>
	<18418.49494.457893.866627@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 1, 2008 at 5:12 PM, Paul Mackerras <paulus@samba.org> wrote:
> Bartlomiej Sieka writes:
>
>  > What about http://patchwork.ozlabs.org/linuxppc/patch?id=17525 ? I don't
>  > see it in the merge branch of your repository, and it would be nice to
>  > get it upstream as it fixes boot problems on some MPC5200-based boards.
>
>  It needs a proper stand-alone commit message and an acked-by from
>  Grant.  The commit message should explain why you are making the
>  changes you are making rather than just saying "the bulk of this patch
>  is taken from http://...".

Total Ack.  I just missed it when it was sent.  But Paul is right, it
needs a real commit message.  Feel free to add my Acked-by: line when
you resend.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
