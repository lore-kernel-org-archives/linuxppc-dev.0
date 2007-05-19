Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 21555DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 May 2007 08:56:37 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so620635ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 May 2007 15:56:36 -0700 (PDT)
Message-ID: <528646bc0705191556v23b91e38h542eddb3d46d0717@mail.gmail.com>
Date: Sat, 19 May 2007 16:56:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: Simple Question about ML403 VGA (TFT) Controller
In-Reply-To: <BAY115-W21F59EB26847913D2C56FB2310@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W21F59EB26847913D2C56FB2310@phx.gbl>
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

On 5/19/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
> How should I add the VGA controller module to my system in XPS?
>
> The base system builder wizard ( EDK 9.1 SP! ) does not provide any option for this, and when I look at the IP repository I do not find any suitable modules to be added to the design.

The VGA controller is not supported by Base system builder.  If you
want to add it to your own design, you need to extract the files from
the ml403 reference design and add them manually to your project.

Cheers,
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
