From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200307310641.h6V6fFC09748@hofr.at>
Subject: Re: What's the maximum number of processes in Linux
In-Reply-To: <20030730044904.2591.qmail@webmail9.rediffmail.com> from ankush
  at "Jul 30, 2003 04:49:04 am"
To: ankush <ankushrb@rediffmail.com>
Date: Thu, 31 Jul 2003 08:41:15 +0200 (CEST)
Cc: Matt Porter <mporter@kernel.crashing.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hi !
>
> Please tell me , How many processes does linux kernel 2.4
> supports.In kernel 2.2 , there was a limit i.e. maximum 512
> processes . But in kerenl 2.4 and above there is no such checking
> being done . I think it just depends upon the available memory.

last time I tried to fork a box into overload it
was the file-descriptors that ran out first (that can be adjusted though)
the limit is not a fixed number, 2.4.X does not have a hard limit
set as maximum number of tasks, its resource limited.

>
> Also please tell me what' s the meaning of process state
> TASK_UNINTERRUPTIBLE in Linux .
>

its ignoring signals (typically blocked on hardware access).

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
