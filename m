Message-ID: <404DEFAB.8070804@denayer.wenk.be>
Date: Tue, 09 Mar 2004 17:24:11 +0100
From: Gerrit Van de Velde <gvd@denayer.wenk.be>
MIME-Version: 1.0
To: "Kevin P. Dankwardt" <k@kcomputing.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: remote access via shell
References: <KCEOLLHGFJIAFNAMGACHEEPJDFAA.k@kcomputing.com>
In-Reply-To: <KCEOLLHGFJIAFNAMGACHEEPJDFAA.k@kcomputing.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using sshd (OpenSSH 3.8-p1 i believe) and sftp-server which are 394k
and 60k in size.
Their makefiles are not well adapted but if you have "Building embedded
linux systems" of O'Reilly, you'll build it without any problem

Kind regards,
Gerrit Van de Velde

Kevin P. Dankwardt wrote:

>I have a ppc 5100 that is currently running Linux. I also have downloaded
>and looked at the ELDK. Neither appear to have a telnet nor a ssh daemon.
>What daemon for remote access is recommended? Are there small versions
>especially appropriate for embedded use? Versions that have Make files
>conducive to cross-compilation for PPC?
>
>Thanks,
>Kevin Dankwardt
>
>


--
Kind regards,
ing. Gerrit Van de Velde

Onderzoeksgroep Digitale Technieken
W & K, Campus De Nayer
J. De Nayerlaan 5
2860 Sint-Katelijne-Waver

Tel. 015 / 31 69 44
Fax. 015 / 31 74 53
http://emsys.denayer.wenk.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
