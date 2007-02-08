Return-Path: <glikely@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by ozlabs.org (Postfix) with ESMTP id 7B5F8DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 03:20:03 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so518421wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Feb 2007 08:20:02 -0800 (PST)
Message-ID: <528646bc0702080820k6e6093bfv1f45d6f45071e4ff@mail.gmail.com>
Date: Thu, 8 Feb 2007 09:20:00 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: pjmaiya <pjmaiya@signal-networks.com>
Subject: Re: CLI for embedded system
In-Reply-To: <011b01c74b81$5604ad80$4601a8c0@signet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <29DC34A6B43468409F5A371CFE34E849091044@ex01.ads.ubidyne.de>
	<011b01c74b81$5604ad80$4601a8c0@signet>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 2/8/07, pjmaiya <pjmaiya@signal-networks.com> wrote:
>
> Hi,
>    Can anybody give me link/built in package or source code for implmenting
> CLI for embedded system on linux. We have tried to implement our own CLI on
> linux(with bash shell as base), but it is massive work since we need to
> support Tab feature, history feature,help etc..

Have you looked at libreadline?  It will do a bunch of that stuff for you.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
