Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BD980B70CD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 06:56:50 +1000 (EST)
To: Rupjyoti Sarmah <rsarmah@amcc.com>
From: Wolfgang Denk <wd@denx.de>
Subject: 
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Wed, 18 Aug 2010 22:56:46 +0200
Message-Id: <20100818205646.57783157D71@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Prodyut Hazarika <phazarika@appliedmicro.com>,
	Mark Miesfeld <mmiesfeld@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Rupjyoti,

drivers/ata/sata_dwc_460ex.c fails to build in current mainline:

...
  CC      drivers/ata/sata_dwc_460ex.o
drivers/ata/sata_dwc_460ex.c:43:1: warning: "DRV_NAME" redefined
In file included from drivers/ata/sata_dwc_460ex.c:38:
drivers/ata/libata.h:31:1: warning: this is the location of the previous definition
drivers/ata/sata_dwc_460ex.c:44:1: warning: "DRV_VERSION" redefined
drivers/ata/libata.h:32:1: warning: this is the location of the previous definition
drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_exec_command_by_tag':
drivers/ata/sata_dwc_460ex.c:1356: warning: passing argument 1 of 'ata_get_cmd_descript' makes integer from pointer without a cast
drivers/ata/sata_dwc_460ex.c: At top level:
drivers/ata/sata_dwc_460ex.c:1592: warning: 'struct of_device' declared inside parameter list
drivers/ata/sata_dwc_460ex.c:1592: warning: its scope is only this definition or declaration, which is probably not what you want
drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_probe':
drivers/ata/sata_dwc_460ex.c:1607: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1614: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1616: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1622: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1628: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1630: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1646: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1650: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1652: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1658: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1660: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1667: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1676: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1678: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1691: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1693: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c: At top level:
drivers/ata/sata_dwc_460ex.c:1705: warning: 'struct of_device' declared inside parameter list
drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_remove':
drivers/ata/sata_dwc_460ex.c:1707: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c:1720: error: dereferencing pointer to incomplete type
drivers/ata/sata_dwc_460ex.c: At top level:
drivers/ata/sata_dwc_460ex.c:1736: warning: initialization from incompatible pointer type
drivers/ata/sata_dwc_460ex.c:1737: warning: initialization from incompatible pointer type
make[2]: *** [drivers/ata/sata_dwc_460ex.o] Error 1

Do you have any hints how to fix that?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Few people do business well who do nothing else.
                                       -- Philip Earl of Chesterfield
