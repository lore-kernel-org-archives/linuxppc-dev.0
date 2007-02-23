Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 3DF10DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 14:56:03 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so651824nfc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 19:56:01 -0800 (PST)
Message-ID: <528646bc0702221956t1028d62ds9b83704452e6c490@mail.gmail.com>
Date: Thu, 22 Feb 2007 20:56:01 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: trembfra@cgocable.ca
Subject: Re: MPC5200 memory mapped IO
In-Reply-To: <45de1855.1b2.2357.4082@cgocable.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <45de1855.1b2.2357.4082@cgocable.ca>
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

On 2/22/07, trembfra@cgocable.ca <trembfra@cgocable.ca> wrote:
> Hi!
>
> I am working on a driver to interface a FPGA chip with the MPC5200 on the local bus plus and I have two questions.
>
> Is it normal that ioremap work without calling mem_request_region before when accessing to mpc5200 registers?

Yes

>
> And do I need to call mem_request_region to access to memory mapped device on local bus plus?

No

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
