Return-Path: <tmarri@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	by ozlabs.org (Postfix) with SMTP id BC145B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Dec 2010 04:53:34 +1100 (EST)
Received: by qwg5 with SMTP id 5so4808376qwg.34
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 09:53:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101210224402.GA8943@kroah.com>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
	<20101210224402.GA8943@kroah.com>
Date: Sat, 11 Dec 2010 09:53:31 -0800
Message-ID: <AANLkTi=NEqh6X0N72jP1W+gzaeFC6Tqs98KpY_OdA6RX@mail.gmail.com>
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Tirumala Marri <tmarri@apm.com>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 10, 2010 at 2:44 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Dec 08, 2010 at 04:28:59PM -0800, tmarri@apm.com wrote:
>> From: Tirumala Marri <tmarri@apm.com>
>>
>> v6:
>> =A01. Replaced register definitions and bit fields with macros.
>> =A02. Replace printks with dev_dbg or dev_err functions.
>> =A03. Cleanup some assignments.
>> =A04. Remove chip specific selections in Kconfig file.
>
> There are still a lot of checkpatch errors and warnings in these
> patches. =A0Patch 1-8 has:
> =A0 =A0 =A0 =A0total: 64 errors, 126 warnings, 13905 lines checked
>
> Care to fix all of these up in your next submission? =A0I can't take thes=
e
> as-is, sorry.
>
> And, if you haven't run checkpatch.pl before, odds are you haven't run
> 'sparse'. =A0Please run that as well and resolve the issues it finds.
>
> thanks,
>
> greg k-h
>
 I will fix the all these errors. Also will run use the sparse tool .
Regards,
Marri
