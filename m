From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16021.61655.348425.683335@nanango.paulus.ozlabs.org>
Date: Fri, 11 Apr 2003 08:31:51 +1000 (EST)
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Machine Check question
In-Reply-To: <20030410013241.3ae349e5.iweiny@acm.org>
References: <20030410013241.3ae349e5.iweiny@acm.org>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ira Weiny writes:

> I have put some more effort into my Microdrive (PCMCIA IDE) problem.

What sort of machine do you have?  There is a known problem on tibooks
where the IDE subsystem ends up trying to use powermac-IDE functions
on PCMCIA IDE drives.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
