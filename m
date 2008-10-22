Return-Path: <Regis.Odeye@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[213.179.130.140]) by ozlabs.org (Postfix) with ESMTP id C12DDDDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 23:59:52 +1100 (EST)
Message-ID: <48FF23C4.5030408@kontron.com>
Date: Wed, 22 Oct 2008 14:59:48 +0200
From: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>
	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>
In-Reply-To: <83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Oct 22, 2008, at 3:59 AM, Régis Odeyé wrote:
>
>> Hello Everyone,
>> I'm looking for some information about the Extended Addressing Mode 
>> (XAEN bit of HID0 register) of PPC32 support in Linux.
>> I do not see anything in the main kernel tree but there may be some 
>> patches available ?
>> Any information will be appreciate.
>> Regards.
>
> There are patches from Becky Bruce that are going into 2.6.28.  What 
> are you needing >32-bit for?  There are some SW IO MMU changes that 
> are still pending to complete this work.
>
> - k
We are developing a board based on Freescale 8641D which can get 4GB of 
ram. So I need 4GB+IOs (~1GB) of physical addressing space.
My plan is to put a part of this ram above of 4GB to keep accesses to 
the IOs below the 4GB limit. It means non-contiguous ram addressing and 
XAEN features to be working.
Where can I glance through Becky patches ?

-- 
Régis ODEYE

Kontron Modular Computers SA
150, rue M. Berthelot / ZI Toulon Est / BP 244 / Fr 83078 TOULON Cedex 9
Phone: (33) 4 98 16 34 86           Fax: (33) 4 98 16 34 01
E-mail: regis.odeye@kontron.com  Web : www.kontron.com
