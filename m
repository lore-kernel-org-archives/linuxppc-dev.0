Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 4628667B30
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 09:38:41 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1100940ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Jun 2006 16:38:40 -0700 (PDT)
Message-ID: <528646bc0606191638j64448168ia19d6a97ab81e648@mail.gmail.com>
Date: Mon, 19 Jun 2006 17:38:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Martin, Tim" <tim.martin@viasat.com>
Subject: Re: Linux on Virtex4
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE48710573FD21@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <821B2170E9E7F04FA38DF7EC21DE48710573FD21@VCAEXCH01.hq.corp.viasat.com>
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

On 6/19/06, Martin, Tim <tim.martin@viasat.com> wrote:
>
> 1) Is there anything obvious from the kernel panics below that I should
> be looking for?  Just the answer "linux 2.4.20 is really fricken old,
> upgrade" is probably the right answer.

I've seen kernel panics when booting large kernel images (>1.5M),
especially when I've welded the kernel image to a system.ace file for
booting via CF.  I haven't tracked down the root cause.  I use both
2.4 and 2.6, and I've seen kernel panics with both.  In your case,
you'll need to decode the backtrace to find out where the kernel is
panicing

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
