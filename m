To: Jure Menart <jure@kom.org>
Cc: qiuqingjun <qiuqingjun@263.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: When does the linuxrc script execute? 
In-Reply-To: Your message of "Tue, 18 Sep 2001 10:25:20 +0200."
             <20010918102520.A12303@hannanges.teden-mladih.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 20 Sep 2001 09:23:51 +0200
From: Wolfgang Denk <wd@denx.de>
Message-Id: <20010920072356.EC9D11009C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> could you be more specific - your system can't really boot without /linuxrc,
> because shell is called in it.

You are wrong. It depends on the kernel configuration and some other things.

> BTW. linuxrc is executed when kernel preparing namespace, that is after all
> initializations, preparing devices... it is in 'init' thread.

If you run in a "standalone shell" environment, there is nothing that will
even bother to check if a /linuxrc exists.

Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
