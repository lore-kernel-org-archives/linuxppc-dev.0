Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 08D49DDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 04:33:51 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1143917anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jan 2008 09:33:50 -0800 (PST)
Message-ID: <fa686aa40801030933t48953a38q4a5bc85a07fbfa02@mail.gmail.com>
Date: Thu, 3 Jan 2008 10:33:50 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: mojtaba <kernelppc@gmail.com>
Subject: Re: File system problem
In-Reply-To: <004901c84e2a$1cac5c70$56051550$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0801021932s6671526dve15d1948da52ae30@mail.gmail.com>
	<004901c84e2a$1cac5c70$56051550$@com>
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

On 1/3/08, mojtaba <kernelppc@gmail.com> wrote:
> Hi Jean-Samuel,
>
> Actually, I removed the console and null created by buildroot and create
> them manually using make node. This time the system freezes at this point.
> "Freeing unused kernel memory: 76k init"

It looks like your inittab is not setup correctly to me.

Do you have a /dev/ttyS0 device file?  Is inittab trying to start a
getty process (getty allows you to log in.)

Try adding "init=/bin/sh" to your kernel boot parameters to prove that
userspace is working.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
