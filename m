Message-ID: <3BBD9FC3.3F742EF6@staubli.com>
Date: Fri, 05 Oct 2001 13:55:48 +0200
From: Pierre AUBERT <p.aubert@staubli.com>
MIME-Version: 1.0
To: Mailing list Embedded linux on PowerPC <linuxppc-embedded@lists.linuxppc.org>
Subject: xconfig
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I have a problem with the 'make xconfig'. I try to use it on a 2.4.10
kernel for power PC, I have the following
error messages when I save the config file :
ERROR - Attempting to write value for unconfigured variable
(CONFIG_SCC_ENET).
ERROR - Attempting to write value for unconfigured variable
(CONFIG_FEC_ENET).

I think that the problem occurs because the both variables are defined
in the files arch/ppc/8xx_io/Config.in
and in the file arch/ppc/8260_io/Config.in.
Is there a patch to fix it ?
PS: I'm using tk-83 and tcl-8.3

Thank you and best regards

--
------------------------------------------------------------------------------
Pierre Aubert                   |   Phone:  +33 4 50 65 62 88
                                |   Fax:    +33 4 50 65 62 08
STÄUBLI Faverges                |
Place Robert STÄUBLI            |   Mailto:p.aubert@staubli.com
74210 Faverges FRANCE           |   http://www.staubli.com
------------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
