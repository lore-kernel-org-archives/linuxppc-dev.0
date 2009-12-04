Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id DA2AFB7BF6
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 05:36:25 +1100 (EST)
Received: by ywh5 with SMTP id 5so2517820ywh.11
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Dec 2009 10:36:24 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091204173902.GK2937@zod.rchland.ibm.com>
References: <20091202091951.5ec6bb83@hyperion.delvare>
	<1259894454.2076.1246.camel@pasglop>
	<20091204103434.0a754925@hyperion.delvare>
	<1259920775.2076.1273.camel@pasglop>
	<1259947019.22783.116.camel@Joe-Laptop.home>
	<20091204173902.GK2937@zod.rchland.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 4 Dec 2009 11:36:03 -0700
Message-ID: <fa686aa40912041036q64c70368oc75e702b819378cd@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add PowerPC patterns
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	Colin Leroy <colin@colino.net>,
	Paul Mackerras <paulus@samba.org>, Joe Perches <joe@perches.com>,
	Jean Delvare <khali@linux-fr.org>, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 4, 2009 at 10:39 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Fri, Dec 04, 2009 at 09:16:59AM -0800, Joe Perches wrote:
>> LINUX FOR POWERPC EMBEDDED PPC4XX
>> M: =A0 =A0Josh Boyer <jwboyer@linux.vnet.ibm.com>
>>@@ -3221,6 +3228,8 @@ W: =A0 =A0 =A0 http://www.penguinppc.org/
>> L: =A0 =A0linuxppc-dev@ozlabs.org
>> T: =A0 =A0git git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powe=
rpc-4xx.git
>> S: =A0 =A0Maintained
>>+F: =A0 =A0arch/powerpc/platforms/40x/
>>+F: =A0 =A0arch/powerpc/platforms/44x/
>
> This is mostly complete. =A0There are a few files under arch/powerpc/sysd=
ev/, and
> arch/powerpc/boot/ as well, but I don't think they're entirely necessary.
>
> For the 4xx parts:
>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
