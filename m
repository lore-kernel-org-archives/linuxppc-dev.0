From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Highmem on PPC?
Date: Thu, 7 Feb 2002 22:59:14 +0100
Message-Id: <20020207215914.30288@smtp.wanadoo.fr>
In-Reply-To: <20020207145620.E19569@boardwalk>
References: <20020207145620.E19569@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The previous kernel was 2.4.12 based, with a hack from me to limit
>lowmem to 512MB.  And I was using SCSI, which has hardware bugs on my
>board, in addition to exercising bounce buffers much more strongly.
>In summary, I don't have the faintest idea what was causing the
>hangs.  I'll try booting my old 2.4.12 kernel NFS root and see if it's
>just as stable.

Could well be a generic kernel bug fixed in the meantime. 2.4.12 wasn't
bug free...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
