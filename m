Date: Fri, 11 Feb 2000 14:08:50 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Dan Malek <dan@netx4.com>
Cc: Stuart <stu@asyn.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hostname problems
Message-ID: <20000211140850.C15548@hq.fsmlabs.com>
References: <000501bf728d$d717f550$0100000a@asyn.com> <38A10693.C75820F4@netx4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38A10693.C75820F4@netx4.com>; from Dan Malek on Wed, Feb 09, 2000 at 01:17:55AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} For the MBX in particular, the support of the PC-style I/O has
} finally been broken.  The support of the IDE was always a problem
} because of the desire to use PCMCIA flash, the QSpan never seemed
} to pass interrupt correctly, and now generic kernel changes finally
} broke the indirect access to the 8259 (and I am still puzzled how
} it is supported on other PMacs.....).

For one, 8259 isn't supported on PMacs :)  I'd found when I first did IDE
on the MBX that there was a lot of contradictory information in the docs on
how those interrupts were passed through.  Matt Porter at Moto finally got
me the correct info (not on Moto time though, I don't want to get him into
trouble...).  If you've found it's not working correctly please let me
know.  I don't claim my understanding or implementation is full or
completely correct.

Can you tell me the 8259 problems you're having?  I'd like to fix those at
least.

} Anyway, those are some of the things I am working on.  There are
} many other little things, like building without PCI configured
} doesn't work either.  The last working 2.3.xx kernel I used and
} updated was 2.3.18.
}
} I am actively working on all of these because I want to make
} sure we have a solid 8xx configuration when 2.4.x hits.
}
} I will make an announcement when I get something stable again.

Please keep me up-to-date with what you do.  I'm trying to get things to a
semi-stable state on all platforms for 2.4.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
