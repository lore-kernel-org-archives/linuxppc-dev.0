Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0554CB6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 23:03:02 +1000 (EST)
Received: by wwg9 with SMTP id 9so70928wwg.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 06:02:58 -0700 (PDT)
Date: Tue, 23 Aug 2011 17:02:53 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] usb: Allocate pram dynamically.
Message-ID: <20110823130253.GA30733@oksana.dev.rtsoft.ru>
References: <1314103121-9857-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1314103121-9857-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2011 at 02:38:41PM +0200, Joakim Tjernlund wrote:
> MPC832x does not have enough MURAM to do fixed MURAM allocation.
> Change to dynamic allocation.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

p.s. You probably want to send this to Greg KH, + Cc linux-usb
mailing list.

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
