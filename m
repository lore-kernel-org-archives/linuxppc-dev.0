Message-ID: <3DFF1DF4.8010005@intracom.gr>
Date: Tue, 17 Dec 2002 14:52:04 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kmalloc and startup process
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I'm hacking now the 8xx hostalloc and dpalloc stuff,
and I have a a question.

At what point in the startup process is it OK to call
kmalloc?

I don't think it is safe at the setup_arch point.

Is this correct?

Thanks

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
