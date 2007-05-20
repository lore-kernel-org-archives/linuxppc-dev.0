Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 7F3C3DDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 May 2007 07:36:25 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so745827ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 May 2007 14:36:23 -0700 (PDT)
Message-ID: <528646bc0705201436m66c61fcj408ddca199cc00da@mail.gmail.com>
Date: Sun, 20 May 2007 15:36:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: ML403 How to change the version of Hard TEMAC from 3.00b to 3.00a?
In-Reply-To: <BAY115-W2577CEA536CA93F444C60B2300@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W2577CEA536CA93F444C60B2300@phx.gbl>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/20/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
> 2- How can I change the version of the used core from 3.00b to 3.00a?

Just change the HW_VER parameter in your system.mhs file.

g.

>
> thanks.
> _________________________________________________________________
> Connect to the next generation of MSN Messenger
> http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
