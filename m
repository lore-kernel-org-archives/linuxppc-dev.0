Message-ID: <004101c39159$73381d00$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <001d01c39133$20f088a0$2803050a@JackyLam> <5.1.0.14.2.20031012203903.02e546d8@mail.ebshome.net> <5.1.0.14.2.20031012235137.02e9d9a8@mail.ebshome.net>
Subject: Re: Walnut PCI bridge can't be detected
Date: Mon, 13 Oct 2003 15:13:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Well, simple answer is "yes". But usually such misconfiguration will
> completely disable kernel access to PCI peripherals or lockup the box
> (which is not your case). This is why I think it's unlikely.
>
> 4xx bridges are quite simple to configure and default setup should be OK,
> especially on reference platform like Walnut.
>
> Broken (on PPC) driver is more probable cause for your problems.
>

    I agree to your point. So, I want to make sure if it is the kernel's PCI
code having problem running on Walnut recently. Is there any maintainer for
walnut platform? Or someone is using PPC kernel on walnut can successfully
using the PCI without any modification?

Regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
