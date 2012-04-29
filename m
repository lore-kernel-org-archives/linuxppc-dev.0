Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 97B94B6FFA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 01:47:10 +1000 (EST)
Received: by iakh37 with SMTP id h37so3557312iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 08:47:08 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9D6277.9080402@lwfinger.net>
Date: Sun, 29 Apr 2012 10:47:03 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] tty/serial/pmac_zilog: Fix "nobody cared" IRQ message
References: <4F9C830D.8040906@lwfinger.net>
 <20120429090520.GA26740@visitor2.iram.es>
In-Reply-To: <20120429090520.GA26740@visitor2.iram.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andreas Schwab <schwab@linux-m68k.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2012 04:05 AM, Gabriel Paubert wrote:
> On Sat, Apr 28, 2012 at 06:53:49PM -0500, Larry Finger wrote:
>
> Hmm, I'm not a native english speaker, but I have the feeling that
> it would be more grammatically correct to use "opened" instead of "open".
>
> Of course if the message never triggers, it's less of concern :-)

English is my native language, but that might not help. :)

I would say "the device has not been opened", but "it is not open". More 
generally, to me "opened" denotes past tense, and "open" is used in the present.

Even with the other bug, the message never triggered as I did not have debugging 
enabled. Given the relative rarity of PPC-based boxes running Linux, the message 
may never print.

Thanks for the comment.

Larry
