Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id CF01E67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 08:30:03 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1216219wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 May 2005 15:30:01 -0700 (PDT)
Message-ID: <528646bc05052615304d896b94@mail.gmail.com>
Date: Thu, 26 May 2005 16:30:01 -0600
From: Grant Likely <glikely@gmail.com>
To: Theo Gjaltema <gjalt007@chello.nl>, linuxppc-embedded@ozlabs.org
In-Reply-To: <429639D5.20609@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <429639D5.20609@chello.nl>
Subject: Re: Dynamic libraries do not work
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/26/05, Theo Gjaltema <gjalt007@chello.nl> wrote:
> Hello,
>=20
> I have a linux 2.4.20 kernel running, but the files in the ramdisk fail
> to execute if they are dynamically build.
> The whole system stops (debuggers shows that it crashed while in an erea
> where no flash/ram is present.
> Anyone an idea?
> There is nog difference between the use of a ramdisk or an nfs mounted
> root filesystem.
>=20
More data please;  Make sure you attach actual output when asking for help.
