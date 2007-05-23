Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id A8D18DDE48
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 02:58:30 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so243060nzb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 09:58:29 -0700 (PDT)
Message-ID: <fa686aa40705230958u7c37dbe8m5ee149082fdb52d2@mail.gmail.com>
Date: Wed, 23 May 2007 10:58:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: ML403 2.6 kernel, root file system on NFS,
	stops after freeing unused kernel memory
In-Reply-To: <BAY115-W12CE664522EEB409218C3FB2350@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W12CE664522EEB409218C3FB2350@phx.gbl>
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

On 5/23/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
> Hi all
>
> I have studied the disscussion here mainly by Mirek32 (I think this was the name)  but unfortunately the disscussion is finished without any suitable answer and solution.
>
> the 2.6 kernel comes up on ml403 with no problem, it gets an IP address from my DHCP and mounts the root file system from my NFS server , all of these are ok.
>
> Unfortunately , after "freeing unused kernel memory ", init , console stops working however the board is alive because it answers all of my pings correctly. I tried to make a telnet connection to the board with no success. ( I'm using ELDK 4.0)
>
> any suggestions what is happening here?

Is there a /dev/console node?

try booting with init=/bin/sh to see if you get a console.

Your /etc/inittab might not be starting a getty on the console device.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
