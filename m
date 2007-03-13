Return-Path: <eswierk@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 3A36DDDF71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 10:00:56 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so2492423nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 16:00:53 -0700 (PDT)
Message-ID: <c1bf1cf0703131145l6be0a02fpec844e7ebec058f8@mail.gmail.com>
Date: Tue, 13 Mar 2007 11:45:45 -0700
From: "Ed Swierk" <eswierk@arastra.com>
Sender: eswierk@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console not working on EP8343M
In-Reply-To: <c1bf1cf0703131122mb959d30v78694fc03bd1d6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
References: <c1bf1cf0703122005l5014824r3e5fbfd50f1974ce@mail.gmail.com>
	<8BE4BF8E-A32E-4984-9B1B-C3B6ED2A1BCA@kernel.crashing.org>
	<c1bf1cf0703131122mb959d30v78694fc03bd1d6b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Another thing I've discovered is that enabling CONFIG_IPMI_HANDLER is
a bad idea, as init_ipmi_si just hangs. I didn't look into why, as I
have no need for IPMI and just disabled it.

--Ed
