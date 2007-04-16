Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id B4F02DDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 02:32:43 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so883031ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 09:32:41 -0700 (PDT)
Message-ID: <528646bc0704160932k2038090al8c0b8e5420422545@mail.gmail.com>
Date: Mon, 16 Apr 2007 10:32:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Mendham" <petermendham@computing.dundee.ac.uk>
Subject: Re: Using Cypress EZ-Host on ML403/5
In-Reply-To: <4623A197.6000104@computing.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4623A197.6000104@computing.dundee.ac.uk>
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

On 4/16/07, Peter Mendham <petermendham@computing.dundee.ac.uk> wrote:
> Dear all,
>
> Has anyone had the Cypress EZ-Host chip working as a USB host under
> Linux?  It's the one that comes fitted as standard to ML403 and ML405
> boards (probably other Xilinx boards too).  If not, can anyone tell me
> where I should start?  Any advice at all?  Our own embedded device needs
> to have USB host support and we are using an ML40x for development so
> the EZ-Host is the preferred solution as we can prototype it.
>
> Thanks in advance,
> --Peter

It's on my task list to get working.  I could certainly use some help.

Xilinx did distrubute some driver code for that host controller a
while back.  I've got a copy of it somewhere.  I'll try to dig it up
today and let you know where you can get it.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
