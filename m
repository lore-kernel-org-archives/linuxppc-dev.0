Subject: Re: kgdb with 2.4.20pre7 kernel on 405 target 
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF324C35E4.14D3AE4E-ONC1256D80.00319F3E-C1256D80.00322E09@megacenter.de.ibm.com>
From: "Michel Normand" <NORMAND@fr.ibm.com>
Date: Tue, 12 Aug 2003 11:08:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


By looking at the history of kgdb problem on 405,  we found the two
following messages
related to kgdb failure on 405 target, messages dated from September 2002:
http://lists.linuxppc.org/linuxppc-embedded/200209/msg00166.html
http://lists.linuxppc.org/linuxppc-embedded/200209/msg00170.html

Is there now  in 2.4.20 kernel a patch to solve this problem ?

>
>  In 2_4_devel, the 4xx debug infrastructure is in the middle of a
> change which moves DBCR state from pt_regs to thread struct.
> Without DBCR being context switched, anything using the 4xx
> debug exception will be adversely affected. This includes
> kgdb and ptrace.
>
>Regards,
> --
>Matt Porter
>porter@cox.net

----
Michel
Internet addr:  normand@fr.ibm.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
