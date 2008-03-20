Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 51098DDF99
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 01:41:47 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so221948anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 07:41:46 -0700 (PDT)
Message-ID: <fa686aa40803200741r304bb1cei5d9562c21d5dff57@mail.gmail.com>
Date: Thu, 20 Mar 2008 08:41:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: Oops with TQM5200 on TQM5200
In-Reply-To: <47E2723D.1090101@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 8:18 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello,
>
>  I just tried Linux 2.6.25-rc6 on my TQM5200 module and got the attached
>  oops. Are there any known patches fixing the problems?
>
>  TIA.

Hmm, I haven't seen this issue on any of my 5200 boards.  To state the
obvious, it's an issue in the bestcomm code.  What source line is
"bcom_task_alloc+0x30/0x198" on?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
