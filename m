Message-ID: <3BEF1034.EBBE37BC@india.infogain.com>
Date: Mon, 12 Nov 2001 05:26:36 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: "OpenPIC versus EPIC" in MPC8240 !
References: <20011107141124.12482.qmail@mailweb22.rediffmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:

sorry for jumping in between as i was out on long leave.
there is absoluetely no relation of bogus interrupts
with "openpic_init" is populating reserved memory areas of EPIC.

even i agree "openpic_init" is populating reserved memory areas of EPIC may
need a second thought.
you should refrain from saying so firmly without tech. support for that.

Best Regards
Ashish

>   Its not a "HACK" dan. Its a bug. Just verify
> the register layout of OpenPIC and EPIC. You
> will find that "openpic_init" is populating
> reserved memory areas of EPIC. No wonder, we get
> bogus interrupts. You can verify this in the code.
>   Moreover Had the code really wanted seperation
> of vector spaces of OpenPIC and EPIC, it should have
> called "openpic_init" with
> "offset value = "NUM_8259_INTERRUPTS"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
