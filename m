Return-Path: <sauron@morannon.org>
Message-ID: <423971A8.5060706@morannon.org>
Date: Thu, 17 Mar 2005 13:01:44 +0100
From: Wouter Thielen <sauron@morannon.org>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: About using ext2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In a mail of May 2nd 2004:

 > > For many classes of embedded system I don't consider unannounced power
 > > failure to be 'mis-use'. That's why we run powerfail tests on JFFS2 and
 >
 > Neither do I. My "mis-use" only referred to the fact of using an ext2
 > filesystem in a system where powerfails are expected to happen.
 >
 > Best regards,
 >
 > Wolfgang Denk

Can't that be fixed somehow in the ext2 code? Anything I should 
check/know when I'm going to try and fix it myself?

-- 
Wouter Thielen
MuLogic B.V. Netherlands
