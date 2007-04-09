Return-Path: <glikely@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id EB31FDDF2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 02:28:37 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so871515wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Apr 2007 09:28:35 -0700 (PDT)
Message-ID: <528646bc0704090928r5b20488br302c4fbca7a6ce6e@mail.gmail.com>
Date: Mon, 9 Apr 2007 10:28:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: Simple experiment with, ML403, running 2.6 kernel ,
	kernel.org source
In-Reply-To: <BAY115-W7520824785D458FBA67FEB2590@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W7520824785D458FBA67FEB2590@phx.gbl>
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

On 4/9/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
> kernel was now able to boot completely on ml403, using 2.6.20.4 kernel
>
> and finally a simple question : so, there was some thing in the mvista .config file, which was not available in .config file of the original kerenl, any body knows what it is?

Probably something in your kernel command line.  Compare
CONFIG_CMDLINE between the two config files.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
