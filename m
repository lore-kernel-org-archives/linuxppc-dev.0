To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ZMII Code Panics on 440GP Ebony
References: <20020524155815.98552.qmail@web21402.mail.yahoo.com>
	<52y9e9ebxm.fsf@topspin.com> <20020524122024.B21309@home.com>
From: Roland Dreier <roland@topspin.com>
Date: 24 May 2002 12:17:47 -0700
In-Reply-To: <20020524122024.B21309@home.com>
Message-ID: <52lma9e4o4.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Matt" == Matt Porter <porter@cox.net> writes:

    Matt> I started some things but have been busy with functionality
    Matt> for some time now.  I'd be interested in any cleanup patches
    Matt> you would produce.  The idea is to separate ibm440.h,
    Matt> ibm440gp.h, and <board>.h as appropriate.  As you've
    Matt> noticed, I took some shortcuts in the interest of getting
    Matt> the core code in front of everybody quickly. :)

OK, I will send you some trivial stuff soon.  I do have one question:
what belongs in ibm440.h (as opposed to ibm440gp.h)?  The only
documentation I have is specifically for the 440GP (other than a
presentation on the 440GX) -- how do we know what is common to the 440
family?

Best,
Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
