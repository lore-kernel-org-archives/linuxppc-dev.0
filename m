Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by ozlabs.org (Postfix) with ESMTP id AFEE1DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 11:14:32 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so1233449ele.3
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 17:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1001.1236642379@neuling.org>
References: <fa686aa40903061008u707b0988s32f04d757d3feb16@mail.gmail.com>
	<1001.1236642379@neuling.org>
Date: Mon, 9 Mar 2009 18:14:30 -0600
Message-ID: <fa686aa40903091714h529a8546s982156fac349c426@mail.gmail.com>
Subject: Re: Please pull mpc52xx-next
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Mikey,

On Mon, Mar 9, 2009 at 5:46 PM, Michael Neuling <mikey@neuling.org> wrote:
> Grant,
>
> Can you grab this guy too?
>
> http://patchwork.ozlabs.org/patch/24082/

Oops, forgot to email you about this one.  I actually wrote another
patch the eliminates the sysfs attributes entirely which also
eliminates the problem.  It will be in my next pull request to Ben
(any day now; just waiting for an ack on another patch).

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
