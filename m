Message-ID: <3BE2C0A5.7080707@elsoft.ch>
Date: Fri, 02 Nov 2001 16:49:57 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Various patches against linuxppc_dev-2.4.14-pre7
Content-Type: multipart/mixed;
 boundary="------------030902090404070703000700"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030902090404070703000700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

   - include/asm-ppc/ibm4xx.h
      missing include file  (I'm not sure if this is the correct fix)

   - drivers/net/ppc405_enet.h
      missing include file  (ditto)

   - arch/ppc/kernel/ppc4xx_setup.c
      added call to board_setup_irq() in ppc4xx_init_IRQ()
      added call to board_setup_rtc_access() in platform_init()

   - arch/ppc/kernel/walnut.c
   - arch/ppc/kernel/redwood.c
   - arch/ppc/kernel/cpci405.c
   - arch/ppc/kernel/ep405.c
      added necessary board_setup_irq() and
      board_setup_rtc_access() functions



Dave


--------------030902090404070703000700
Content-Type: application/octet-stream;
 name="various_patches.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="various_patches.bz2"

QlpoOTFBWSZTWU/LefIAAqzfgDAwWn///3/v//6/7//aUAVZ7HXS66u9l4AAoCRJI1PVP1T9
U8mUaemQeqNk2phQDIyNGQAA2RAySNoEmk2o00NGgBo0AaAAAAaAAkRJNoqZP1AmmQ0MRgEw
QBo00wEBpoMIqinoj9KaeoeiA0AAAyDQGTQDQHqAAikFPQIEYmmp5JqGjQHqGNEAAGgyaNHq
aAlkmPhUtGxzMSScSOVjaJUlFDCAsGELRyjJ5LaGzipolGafE5k/791k0oPwxWbSG8eSk9bz
mNO6I06r7YlQzBlELkdS5AULXLkBO4IcXss2kp6SmCKaJ4JmGBIWtA0Kw6vpqf84s29ZLRBB
axCLNRVouvHeODfbZjhQ26zOGlqidKgmel3e674RI4A1fv9APEf0RItYkti5R2qpm5Fh5tZU
kwUsuistBAZv3SNSaxkhQL0RfwaQuCEpiXEwDhIWldPWT6yolK9bJIXbyBlw5VtxQlaMx4EF
8YuG7e6psMFAsDVhzNuWkex+mHHIydddxYJIdqUDA0ISkkMQHJ83ZHP3tGDQ4ZG3LPLPuWpp
s9upGkSaVwR4R61XbEu/Sb5PEERKUpEpM7FMZK8lfFGrYBZlcOEc5zbz3g4qsrDZUWZ8qlDW
Vl0ykshWaqSzFVBcbTpiQQd4XVMWDxvFSGkUpAsFdBzTF7PESKyysLx+ewIoQOYUUxGK8sSv
xiBK64d0jYIjhAwL4ojC97yHSUZguaKIEsnFEIRsDvaVJoFRwgawZIotre3elhaGFUZAQSEu
ipfMK6K3QHIqKm6qwahcxZTMYyyHzpiB00pCfDViVkcYJbSE5xU8m07+WAxvChjCdx11fjcQ
eUSawNCgEmlYueBXOQEkEkEueZQ3T41OuinAje88Lx81Y/X0oOAAPoFekdjPUIZIprDj3g3o
EasBQgMkGARNPNUFa0t94zUhrwPgCoG1A4T53dd/5WxXvfw0xr0APyLcarmNhNmN8fWhSUmG
2dsx02C9TE42KdCSOLSYDWlaQsspdTtSwwFaBcjJIS9ICEjMlUzyjEeztsJ6AS97mgnlxsYB
eecxgiCIIgjUISfSl5o9R4CtrudJDTzBKUgl5aEmp+AhN3AsfniOtSdBZTCK5redfruNy6kC
uA7y3O0LlINYVPEECZs0lwRvIVm7RaL69+YAsJhZH1AQQ6T0mj1z2X0ZiZCy1OE3YBpKy5TJ
bGGRgQQJgJsKEhJi3iyZhcrrM7nfJobFdPLEOtXU5alzj6OBEsuaihnsazidLtdEjVukZVly
xKBPjux9krR5kCAKSlk+EafLrAzE4Y/2XcbU4HOYcjpOoF3vUYEWsMgLzKl4ctgPRq0N06Ok
ziSGewGwlBa8ZukLle+JhwVkJbr3ZY1PAwGBaFOIEkmJXSIcTZSQSyNIdxWUVU21ZzorN1hv
ooczDxE6SSaBCj0ZmqOs4Ase4z0dqGfrMiHgTZC8RE/swd28goHhdghvO9JlIXeFufI3rLGZ
HRtEgsoFM4mKJUapUuAYmOJXYBWiVgsTKJjSEyzrCdtwu2EIFxrAm1WMUOcI78ZqxBEPEnVJ
hCZYiTvKgPvhfTCK4hlFFbVBOI8lN/IEgMB4IXglwXF/tgQHWrYSS8Xe3Canawt4eYTsLjEC
CIYX/xdyRThQkE/LefI=
--------------030902090404070703000700--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
