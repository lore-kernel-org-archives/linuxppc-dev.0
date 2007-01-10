Return-Path: <martineschen@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 6E19BDDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 22:07:39 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so63938ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 03:07:34 -0800 (PST)
Message-ID: <3acfce80701100307o18a24b37q616bb0c8ec4086dd@mail.gmail.com>
Date: Wed, 10 Jan 2007 09:07:29 -0200
From: "Daniel Martineschen" <martineschen@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 + boa webserver + CGI + broken pipe
In-Reply-To: <20070110005407.46FF635264F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <3acfce80701091001u27cac269q2fa227daf543a7d4@mail.gmail.com>
	<20070110005407.46FF635264F@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/9/07, Wolfgang Denk <wd@denx.de> wrote:
> > Machine check in kernel mode.
>
> This is most probably a hardware issue (bad SDRAM initialization?)

yes, but why does it happen only when we use the boa webserver? when
boa is not running, the system works perfectly. moreover, when we
restart it (by kill-HUP-ing him), then the system shows these messages
and halts.
My point is: is it really a bad choice to use boa? can boa really be
causing so much trouble?

regards,
Daniel


-- 
---
Daniel Martineschen
http://www.inf.ufpr.br/danielm
