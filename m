Message-ID: <3EE8C02C.6050201@mvista.com>
Date: Thu, 12 Jun 2003 11:02:20 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: erik.teose@exgate.tek.com
Cc: fray@mvista.com, Christophe.LINDHEIMER@fr.thalesgroup.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Running Linux with 2Mo of Ram.
References: <BA0E4392AD99D040885C414D992C24BE0361528A@us-bv-m11>
In-Reply-To: <BA0E4392AD99D040885C414D992C24BE0361528A@us-bv-m11>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


erik.teose@exgate.tek.com wrote:

> MontaVista's "Consumer Electronics Edition" does xip (execute in place) from
> rom. From what I understand, MV has been fairly good about folding their
> updates back into the open source world (e.g. real time enhancements to the
> kernel). Has this changed?

No.  MontaVista has currently implemented XIP only on ARM (which is the
only arch supported in Consumer Electronics Edition at present), and we
contributed that code back to the ARM community.  We are currently
working on other architectures and will contribute the code back to the
community as we go.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
