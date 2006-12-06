Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 7D1AE67C0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 10:11:32 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so280096ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Dec 2006 15:11:30 -0800 (PST)
Message-ID: <528646bc0612061511v5bfe5f8di9eb7f160221828da@mail.gmail.com>
Date: Wed, 6 Dec 2006 16:11:29 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: How to use the device tree for lite5200
In-Reply-To: <45771721.1080102@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4576E8CC.6050508@grandegger.com>
	<B1186D1B-C47D-46C3-B928-8FDE4A55363B@kernel.crashing.org>
	<45771721.1080102@grandegger.com>
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

On 12/6/06, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Great, that worked with the additional "-f" option, as suggested by
> Grant. Now I can boot the kernel but BESTCOM and FEC support seem still
> missing. Are there already patches around?

They are not in mainline as they are undergoing rework; I've got
working drivers in my tree.  see here:

http://git.secretlab.ca

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
